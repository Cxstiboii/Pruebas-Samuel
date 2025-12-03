package com.example.OinkCoin;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude = {SecurityAutoConfiguration.class})
public class OinkCoinApplication {

    public static void main(String[] args) {
        SpringApplication.run(OinkCoinApplication.class, args);
    }
}