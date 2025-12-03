package com.example.OinkCoin.repository;

import java.time.LocalDateTime;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.OinkCoin.model.PasswordResetToken;
import com.example.OinkCoin.model.Usuario;

@Repository
public interface PasswordResetTokenRepository extends JpaRepository<PasswordResetToken, Integer>{
    
    Optional<PasswordResetToken> findByToken(String token);
    Optional<PasswordResetToken> findByUsuarioAndUsadoFalseAndFechaExpiracionAfter(
        Usuario usuario, LocalDateTime now
    );

    //Eliminar tokens expirados(Util para limpieza)
    @Modifying
    @Query("DELETE FROM PasswordResetToken t WHERE t.fechaExpiracion < :now")
    void deleteExpiredTokens(LocalDateTime now);

    //Eliminar tokens antiguos del usuario
    @Modifying
    @Query("DELETE FROM PasswordResetToken t WHERE t.usuario = :usuario")
    void deleteTokensByUsuario(Usuario usuario);
}
