package com.example.batchspringboot.config;

import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBWritingTasklet implements Tasklet {

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        try (Connection connection = DriverManager.getConnection("jdbc:h2:file:D:/IntelliJ/batchspringboot/src/main/resources/schema.sql","sa","");
             Statement statement = connection.createStatement();
             ResultSet resultSet =statement.executeQuery("SELECT * FROM Customer_info")) {
                try (BufferedWriter writer = new BufferedWriter(new FileWriter("output.txt"))){
                    while (resultSet.next()){
                        writer.write(resultSet.getInt("customer_id") + ","
                                + resultSet.getString("first_name") + ","
                                + resultSet.getString("last_name") + ","
                                + resultSet.getString("email") + ","
                                + resultSet.getString("gender") + ","
                                + resultSet.getString("contact") + ","
                                + resultSet.getString("country") + "\n");
                    }
                }
        }
        return  RepeatStatus.FINISHED;
    }
}
