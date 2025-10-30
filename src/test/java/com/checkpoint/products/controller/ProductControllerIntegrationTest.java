package com.checkpoint.products.controller;

import com.checkpoint.products.dto.ProductDTO;
import com.checkpoint.products.entity.Product;
import com.checkpoint.products.repository.ProductRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureWebMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import java.math.BigDecimal;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureWebMvc
@ActiveProfiles("test")
@Transactional
public class ProductControllerIntegrationTest {

    @Autowired
    private WebApplicationContext webApplicationContext;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private ObjectMapper objectMapper;

    private MockMvc mockMvc;

    @BeforeEach
    void setUp() {
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
        productRepository.deleteAll();
    }    @Test
    void testCreateProduct() throws Exception {
        ProductDTO productDTO = new ProductDTO("Test Product", "Test Description", new BigDecimal("99.99"), 10);

        mockMvc.perform(post("/api/products")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(productDTO)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.name").value("Test Product"))
                .andExpect(jsonPath("$.description").value("Test Description"))
                .andExpect(jsonPath("$.price").value(99.99))
                .andExpect(jsonPath("$.quantity").value(10));
    }

    @Test
    void testGetAllProducts() throws Exception {
        // Create test products
        Product product1 = new Product("Product 1", "Description 1", new BigDecimal("10.00"), 5);
        Product product2 = new Product("Product 2", "Description 2", new BigDecimal("20.00"), 10);
        productRepository.save(product1);
        productRepository.save(product2);

        mockMvc.perform(get("/api/products"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(2))
                .andExpect(jsonPath("$[0].name").value("Product 1"))
                .andExpect(jsonPath("$[1].name").value("Product 2"));
    }

    @Test
    void testGetProductById() throws Exception {
        Product product = new Product("Test Product", "Test Description", new BigDecimal("99.99"), 10);
        Product savedProduct = productRepository.save(product);

        mockMvc.perform(get("/api/products/{id}", savedProduct.getId()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(savedProduct.getId()))
                .andExpect(jsonPath("$.name").value("Test Product"));
    }

    @Test
    void testGetProductByIdNotFound() throws Exception {
        mockMvc.perform(get("/api/products/{id}", 999L))
                .andExpect(status().isNotFound())
                .andExpect(jsonPath("$.message").value("Product not found with id: 999"));
    }

    @Test
    void testUpdateProduct() throws Exception {
        Product product = new Product("Original Product", "Original Description", new BigDecimal("50.00"), 5);
        Product savedProduct = productRepository.save(product);

        ProductDTO updateDTO = new ProductDTO("Updated Product", "Updated Description", new BigDecimal("75.00"), 15);

        mockMvc.perform(put("/api/products/{id}", savedProduct.getId())
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(updateDTO)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.name").value("Updated Product"))
                .andExpect(jsonPath("$.description").value("Updated Description"))
                .andExpect(jsonPath("$.price").value(75.00))
                .andExpect(jsonPath("$.quantity").value(15));
    }    @Test
    void testDeleteProduct() throws Exception {
        Product product = new Product("Product to Delete", "Description", new BigDecimal("25.00"), 3);
        Product savedProduct = productRepository.save(product);

        mockMvc.perform(delete("/api/products/{id}", savedProduct.getId()))
                .andExpect(status().isNoContent());

        mockMvc.perform(get("/api/products/{id}", savedProduct.getId()))
                .andExpect(status().isNotFound());
    }

    @Test
    void testCreateProductWithInvalidData() throws Exception {
        ProductDTO invalidProductDTO = new ProductDTO("", "Description", new BigDecimal("-10.00"), -5);

        mockMvc.perform(post("/api/products")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(invalidProductDTO)))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.fieldErrors.name").exists())
                .andExpect(jsonPath("$.fieldErrors.price").exists())
                .andExpect(jsonPath("$.fieldErrors.quantity").exists());
    }

    @Test
    void testSearchProductsByName() throws Exception {
        Product product1 = new Product("Laptop Dell", "Dell Laptop", new BigDecimal("1000.00"), 5);
        Product product2 = new Product("Desktop Dell", "Dell Desktop", new BigDecimal("800.00"), 3);
        Product product3 = new Product("Mouse", "Wireless Mouse", new BigDecimal("30.00"), 10);
        
        productRepository.save(product1);
        productRepository.save(product2);
        productRepository.save(product3);

        mockMvc.perform(get("/api/products/search")
                .param("name", "Dell"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(2))
                .andExpect(jsonPath("$[0].name").value("Laptop Dell"))
                .andExpect(jsonPath("$[1].name").value("Desktop Dell"));
    }
}
