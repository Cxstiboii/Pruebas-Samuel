package com.example.OinkCoin.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import com.example.OinkCoin.repository.UsuarioRepository;

@Component
public class TestConection implements CommandLineRunner {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Override
    public void run(String... args) throws Exception {
        System.out.println("🔍 Probando conexión a MySQL...");
        
        try {
            // Intenta contar los usuarios (prueba la conexión)
            usuarioRepository.count();
            System.out.println("✅ CONEXIÓN A MYSQL EXITOSA");
            
        } catch (Exception e) {
            System.err.println("❌ FALLÓ LA CONEXIÓN A MYSQL: " + e.getMessage());
        }
    }
}