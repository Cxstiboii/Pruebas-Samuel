package com.example.OinkCoin.service;

public interface PasswordResetService {
    void crearTokenRecuperacion(String email);
    boolean validarToken(String token);
    void cambiarPassword(String token, String newPassword);
}
