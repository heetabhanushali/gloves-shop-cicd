package com.glovesshop.shipping;

import org.springframework.jdbc.datasource.AbstractDataSource;
import org.springframework.retry.annotation.Backoff;
import org.springframework.retry.annotation.Retryable;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class RetryableDataSource extends AbstractDataSource {

    private DataSource delegate;

    public RetryableDataSource(DataSource delegate) {
        this.delegate = delegate;
    }

    @Override
    @Retryable(maxAttempts = 10, backoff = @Backoff(delay = 5000, multiplier = 1.5))
    public Connection getConnection() throws SQLException {
        return delegate.getConnection();
    }

    @Override
    @Retryable(maxAttempts = 10, backoff = @Backoff(delay = 5000, multiplier = 1.5))
    public Connection getConnection(String username, String password) throws SQLException {
        return delegate.getConnection(username, password);
    }
}
