package com.backend.testManagement.dto;

import com.backend.testManagement.model.Test;
import lombok.*;

import javax.validation.constraints.*;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TestDTOSave {

    @NotBlank(message = "Titulli është i detyrueshëm")
    @Size(min = 3, max = 200, message = "Titulli duhet të jetë midis 3 dhe 200 karaktere")
    private String title;

    @Size(max = 1000, message = "Përshkrimi nuk mund të kalojë 1000 karaktere")
    private String description;

    @NotBlank(message = "Lënda është e detyrueshme")
    @Size(min = 2, max = 100, message = "Lënda duhet të jetë midis 2 dhe 100 karaktere")
    private String subject;

    @Min(value = 1, message = "Kohëzgjatja duhet të jetë të paktën 1 minutë")
    @Max(value = 300, message = "Kohëzgjatja nuk mund të kalojë 300 minuta")
    private Integer durationMinutes;

    @Min(value = 1, message = "Duhet të ketë të paktën 1 pyetje")
    @Max(value = 200, message = "Nuk mund të ketë më shumë se 200 pyetje")
    private Integer totalQuestions;

    @DecimalMin(value = "0.0", message = "Nota kalimtare nuk mund të jetë negative")
    @DecimalMax(value = "100.0", message = "Nota kalimtare nuk mund të kalojë 100")
    private Double passingScore;

    @NotNull(message = "Niveli i vështirësisë është i detyrueshëm")
    private Test.DifficultyLevel difficultyLevel;

    private Test.TestStatus status;
    private String createdBy;
}
