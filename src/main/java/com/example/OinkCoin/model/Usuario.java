package com.example.OinkCoin.model;

import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "usuario")
@Data // ← ESTO GENERA LOS GETTERS Y SETTERS AUTOMÁTICAMENTE
@NoArgsConstructor
@AllArgsConstructor
public class Usuario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_usuario")
    private Integer idUsuario;

    @NotBlank(message = "El nombre no puede estar vacío")
    @Size(max = 100, message = "El nombre no puede tener más de 100 caracteres")
    @Column(name = "nombre_usuario", nullable = false, length = 100)
    private String nombreUsuario;

    @NotBlank(message = "El correo no puede estar vacío")
    @Email(message = "El correo debe ser válido")
    @Column(name = "email_usuario", nullable = false, unique = true, length = 100)
    private String emailUsuario;

    @NotBlank(message = "La contraseña no puede estar vacía")
    @Size(min = 8, message = "La contraseña debe tener al menos 8 caracteres")
    @Column(name = "password_usuario", nullable = false)
    private String passwordUsuario;

    @CreationTimestamp
    @Column(name = "fecha_registro", nullable = false, updatable = false)   
    private LocalDateTime fechaRegistro;

    @Column(name = "foto_perfil", length = 250)
    private String fotoPerfil;

    
}