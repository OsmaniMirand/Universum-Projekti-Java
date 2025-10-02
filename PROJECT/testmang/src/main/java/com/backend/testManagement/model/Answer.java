package com.backend.testManagement.model;

import lombok.*;

import javax.persistence.*;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "answer")
@Entity
@Builder
public class Answer {

    @Id
    @Column(name = "id")
    private final String id = UUID.randomUUID().toString();

    @Column(name = "answer_text", nullable = false)
    private String answerText;

    @Column(name = "is_correct")
    private Boolean isCorrect;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id")
    private Question question;

    @Column(name = "order_index")
    private Integer orderIndex;
}