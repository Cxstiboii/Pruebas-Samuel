package com.example.OinkCoin.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.example.OinkCoin.service.EmailService;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;


@Service
public class EmailServiceImpl implements EmailService {
    
    @Autowired
    private JavaMailSender mailSender;

    @Value("${app.base.url}")
    private String baseUrl;

    @Override
    public void enviarEmailRecuperacion(String destinatario, String token){
        try{
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setTo(destinatario);
            helper.setSubject("OinkCoin - Recuperacion de contraseña");

            String contenidoHtml = construirEmailHTML(token);
            helper.setText(contenidoHtml, true);

            mailSender.send(message);
        }catch (MessagingException e){
            throw new RuntimeException("Error al enviar el correo electronico", e);
        }
    }

private String construirEmailHTML(String token){
    // ✅ URL CORREGIDA - ahora apunta a /login/reset-password
    String resetUrl = baseUrl + "/login/reset-password?token=" + token;

    return "<!DOCTYPE html>" +
        "<html lang='es'>" +
        "<head>" +
        "    <meta charset='UTF-8'>" +
        "    <meta name='viewport' content='width=device-width, initial-scale=1.0'>" +
        "    <title>Restablecer Contraseña - OinkCoin</title>" +
        "    <style>" +
        "        :root {" +
        "            --primary: #3EBD93;" +
        "            --secondary: #4ECDC4;" +
       "        }" +
       "        " +
       "        body {" +
       "            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;" +
       "            line-height: 1.6;" +
       "            margin: 0;" +
       "            padding: 0;" +
       "            background-color: #f5f5f5;" +
       "            color: #2C3E50;" +
       "        }" +
       "        " +
       "        .email-container {" +
       "            max-width: 600px;" +
       "            margin: 0 auto;" +
       "            background-color: white;" +
       "            border-radius: 12px;" +
       "            overflow: hidden;" +
       "            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);" +
       "        }" +
       "        " +
       "        .header {" +
       "            background: linear-gradient(135deg, var(--primary), var(--secondary));" +
       "            color: white;" +
       "            padding: 40px 20px;" +
       "            text-align: center;" +
       "        }" +
       "        " +
       "        .logo {" +
       "            font-size: 32px;" +
       "            font-weight: bold;" +
       "            margin-bottom: 10px;" +
       "        }" +
       "        " +
       "        .content {" +
       "            padding: 40px 30px;" +
       "            background-color: white;" +
       "        }" +
       "        " +
       "        .title {" +
       "            color: #2C3E50;" +
       "            font-size: 24px;" +
       "            font-weight: 600;" +
       "            margin-bottom: 20px;" +
       "        }" +
       "        " +
       "        .message {" +
       "            color: #8D99AE;" +
       "            font-size: 16px;" +
       "            margin-bottom: 25px;" +
       "            line-height: 1.7;" +
       "        }" +
       "        " +
       "        .button-container {" +
       "            text-align: center;" +
       "            margin: 30px 0;" +
       "        }" +
       "        " +
       "        .reset-button {" +
       "            display: inline-block;" +
       "            padding: 14px 32px;" +
       "            background: linear-gradient(135deg, var(--primary), var(--secondary));" +
       "            color: white !important;" +
       "            text-decoration: none;" +
       "            border-radius: 8px;" +
       "            font-weight: 600;" +
       "            font-size: 16px;" +
       "            transition: all 0.3s ease;" +
       "            box-shadow: 0 4px 15px rgba(62, 189, 147, 0.3);" +
       "        }" +
       "        " +
       "        .reset-button:hover {" +
       "            transform: translateY(-2px);" +
       "            box-shadow: 0 6px 20px rgba(62, 189, 147, 0.4);" +
       "        }" +
       "        " +
       "        .security-note {" +
       "            background-color: #F7F9FA;" +
       "            border-left: 4px solid var(--primary);" +
       "            padding: 15px 20px;" +
       "            margin: 25px 0;" +
       "            border-radius: 4px;" +
       "        }" +
       "        " +
       "        .warning {" +
       "            color: #8D99AE;" +
       "            font-size: 14px;" +
       "            text-align: center;" +
       "            margin-top: 20px;" +
       "        }" +
       "        " +
       "        .footer {" +
       "            background-color: #F7F9FA;" +
       "            padding: 30px 20px;" +
       "            text-align: center;" +
       "            color: #8D99AE;" +
       "            font-size: 14px;" +
       "        }" +
       "        " +
       "        @media only screen and (max-width: 600px) {" +
       "            .content {" +
       "                padding: 30px 20px;" +
       "            }" +
       "            " +
       "            .title {" +
       "                font-size: 20px;" +
       "            }" +
       "            " +
       "            .reset-button {" +
       "                padding: 12px 24px;" +
       "                font-size: 14px;" +
       "            }" +
       "        }" +
       "    </style>" +
       "</head>" +
       "<body>" +
       "    <div class='email-container'>" +
       "        <div class='header'>" +
       "            <div class='logo'>OinkCoin</div>" +
       "            <h1>Recupera tu Acceso</h1>" +
       "        </div>" +
       "        " +
       "        <div class='content'>" +
       "            <h2 class='title'>Restablece tu Contraseña</h2>" +
       "            " +
       "            <p class='message'>" +
       "                Hola,<br><br>" +
       "                Recibimos una solicitud para restablecer la contraseña de tu cuenta en OinkCoin. " +
       "                Haz clic en el siguiente botón para crear una nueva contraseña segura." +
       "            </p>" +
       "            " +
       "            <div class='button-container'>" +
       "                <a href='" + resetUrl + "' class='reset-button'>Restablecer Contraseña</a>" +
       "            </div>" +
       "            " +
       "            <div class='security-note'>" +
       "                <strong> Importante:</strong> Este enlace es de un solo uso y expirará en <strong>10 minutos</strong> " +
       "                por motivos de seguridad. Si no realizas la acción en este tiempo, deberás solicitar un nuevo enlace." +
       "            </div>" +
       "            " +
       "            <p class='message'>" +
       "                Si no reconoces esta actividad o no solicitaste el restablecimiento de contraseña, " +
       "                por favor ignora este mensaje y verifica la seguridad de tu cuenta." +
       "            </p>" +
       "            " +
       "            <p class='warning'>" +
       "                ¿Problemas con el botón? Copia y pega este enlace en tu navegador:<br>" +
       "                <span style='color: var(--primary); font-size: 12px; word-break: break-all;'>" + resetUrl + "</span>" +
       "            </p>" +
       "        </div>" +
       "        " +
       "        <div class='footer'>" +
       "            <p><strong>OinkCoin - Gestión Inteligente de Finanzas Personales</strong></p>" +
       "            <p>Controla tus gastos, alcanza tus metas y mejora tu salud financiera</p>" +
       "            " +
       "            <p style='margin-top: 20px; font-size: 12px; color: #8D99AE;'>" +
       "                © 2024 OinkCoin. Todos los derechos reservados.<br>" +
       "                Este es un correo automático, por favor no respondas a este mensaje." +
       "            </p>" +
       "        </div>" +
       "    </div>" +
       "</body>" +
       "</html>";
    }
}