package com.drizzlepal.nacos.plugin.datasource.impl.postgresql;

public class NotFoundException extends RuntimeException {

    public NotFoundException(String message) {
        super(message);
    }

}
