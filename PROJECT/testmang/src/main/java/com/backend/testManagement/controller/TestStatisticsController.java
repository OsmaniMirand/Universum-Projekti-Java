package com.backend.testManagement.controller;

import com.backend.testManagement.model.Test;
import com.backend.testManagement.services.TestService;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/test-statistics")
public class TestStatisticsController {

    private final TestService testService;

    @Autowired
    public TestStatisticsController(TestService testService) {
        this.testService = testService;
    }

    @GetMapping("/summary")
    @ApiResponse(responseCode = "200", description = "Statistikat e përgjithshme të testeve")
    public ResponseEntity<Map<String, Object>> getTestSummary() {
        Map<String, Object> summary = new HashMap<>();
        
        // Këtu mund të shtosh logjikën për statistika
        summary.put("totalTests", 0); // Do të implementohet
        summary.put("activeTests", 0);
        summary.put("draftTests", 0);
        summary.put("averageDuration", 0);
        
        return ResponseEntity.ok(summary);
    }

    @GetMapping("/by-difficulty")
    @ApiResponse(responseCode = "200", description = "Testet e grupuara sipas vështirësisë")
    public ResponseEntity<Map<Test.DifficultyLevel, Long>> getTestsByDifficulty() {
        Map<Test.DifficultyLevel, Long> difficultyStats = new HashMap<>();
        
        // Implemento logjikën për të numëruar testet sipas vështirësisë
        difficultyStats.put(Test.DifficultyLevel.EASY, 0L);
        difficultyStats.put(Test.DifficultyLevel.MEDIUM, 0L);
        difficultyStats.put(Test.DifficultyLevel.HARD, 0L);
        
        return ResponseEntity.ok(difficultyStats);
    }

    @GetMapping("/by-subject")
    @ApiResponse(responseCode = "200", description = "Testet e grupuara sipas lëndës")
    public ResponseEntity<Map<String, Long>> getTestsBySubject() {
        Map<String, Long> subjectStats = new HashMap<>();
        
        // Implemento logjikën për të numëruar testet sipas lëndës
        
        return ResponseEntity.ok(subjectStats);
    }
}