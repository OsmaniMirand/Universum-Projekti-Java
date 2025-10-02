package com.backend.testManagement.mapper;

import com.backend.testManagement.dto.TestDTO;
import com.backend.testManagement.dto.TestDTOSave;
import com.backend.testManagement.model.Test;
import org.springframework.stereotype.Component;

@Component
public class TestMapper {

    public TestDTO mapToDTO(Test test) {
        return TestDTO.builder()
                .id(test.getId())
                .title(test.getTitle())
                .description(test.getDescription())
                .subject(test.getSubject())
                .durationMinutes(test.getDurationMinutes())
                .totalQuestions(test.getTotalQuestions())
                .passingScore(test.getPassingScore())
                .difficultyLevel(test.getDifficultyLevel())
                .status(test.getStatus())
                .createdBy(test.getCreatedBy())
                .createdAt(test.getCreatedAt())
                .updatedAt(test.getUpdatedAt())
                .build();
    }

    public Test mapToEntity(TestDTOSave testDTO) {
        return Test.builder()
                .title(testDTO.getTitle())
                .description(testDTO.getDescription())
                .subject(testDTO.getSubject())
                .durationMinutes(testDTO.getDurationMinutes())
                .totalQuestions(testDTO.getTotalQuestions())
                .passingScore(testDTO.getPassingScore())
                .difficultyLevel(testDTO.getDifficultyLevel())
                .status(testDTO.getStatus())
                .createdBy(testDTO.getCreatedBy())
                .build();
    }
}