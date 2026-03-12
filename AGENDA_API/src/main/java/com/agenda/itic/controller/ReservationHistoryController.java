package com.agenda.itic.controller;

import com.agenda.itic.model.ReservationHistory;
import com.agenda.itic.service.ReservationHistoryService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/reservation-history")
public class ReservationHistoryController {

    private final ReservationHistoryService reservationHistoryService;

    public ReservationHistoryController(ReservationHistoryService reservationHistoryService) {
        this.reservationHistoryService = reservationHistoryService;
    }

    @GetMapping
    public List<ReservationHistory> findAll() {
        return reservationHistoryService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<ReservationHistory> findById(@PathVariable Long id) {
        return reservationHistoryService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/reservation/{reservationId}")
    public List<ReservationHistory> findByReservation(@PathVariable Long reservationId) {
        return reservationHistoryService.findByReservationId(reservationId);
    }

    @PostMapping
    public ReservationHistory create(@RequestBody ReservationHistory history) {
        return reservationHistoryService.save(history);
    }
}
