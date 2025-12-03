package com.example.OinkCoin.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "password_reset_token")
@Data
@NoArgsConstructor
@AllArgsConstructor

public class PasswordResetToken {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_token")
    private Integer idToken;

    @Column(name = "token", nullable = false , unique = true)
    private String token;

    @Column(name = "fecha_expiracion", nullable = false)
    private LocalDateTime fechaExpiracion;

    @Column(name = "usado", nullable = false)
    private Boolean usado;

    @Column(name = "fecha_creacion", nullable = false, updatable= false)
    private LocalDateTime fechaCreacion;


    @ManyToOne(fetch= FetchType.LAZY)
    @JoinColumn(name = "id_usuario", nullable = false)
    private Usuario usuario;


    @PrePersist
    protected void onCreate(){
        fechaCreacion = LocalDateTime.now();
    }

    //Metodo util para verificar si el token ha expirado
    public boolean isExpired() {
        return LocalDateTime.now().isAfter(this.fechaExpiracion);
    }

}
