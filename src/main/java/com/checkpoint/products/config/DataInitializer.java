package com.checkpoint.products.config;

import com.checkpoint.products.entity.Product;
import com.checkpoint.products.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private ProductRepository productRepository;

    @Override
    public void run(String... args) throws Exception {
        if (productRepository.count() == 0) {
            // Initialize with sample data
            productRepository.save(new Product("Notebook Dell", "Notebook Dell Inspiron 15", new BigDecimal("2999.99"), 10));
            productRepository.save(new Product("Mouse Logitech", "Mouse sem fio Logitech MX Master", new BigDecimal("299.99"), 25));
            productRepository.save(new Product("Teclado Mecânico", "Teclado mecânico RGB", new BigDecimal("199.99"), 15));
            productRepository.save(new Product("Monitor Samsung", "Monitor Samsung 24 polegadas", new BigDecimal("899.99"), 8));
            productRepository.save(new Product("Webcam HD", "Webcam Full HD 1080p", new BigDecimal("149.99"), 20));
            
            System.out.println("Sample data initialized successfully!");
        }
    }
}
