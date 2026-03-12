package com.agenda.itic.controller;

import com.agenda.itic.model.ReservationRequest;
import com.agenda.itic.service.ReservationRequestService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/reservation-requests")
public class ReservationRequestController {

    private final ReservationRequestService reservationRequestService;

    public ReservationRequestController(ReservationRequestService reservationRequestService) {
        this.reservationRequestService = reservationRequestService;
    }

    @GetMapping
    public List<ReservationRequest> findAll() {
        return reservationRequestService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<ReservationRequest> findById(@PathVariable Long id) {
        return reservationRequestService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/status/{status}")
    public List<ReservationRequest> findByStatus(@PathVariable String status) {
        return reservationRequestService.findByStatus(status);
    }

    @GetMapping("/user/{userId}")
    public List<ReservationRequest> findByUser(@PathVariable Long userId) {
        return reservationRequestService.findByUserId(userId);
    }

    @PostMapping
    public ReservationRequest create(@RequestBody ReservationRequest request) {
        request.setStatus("PENDING");
        return reservationRequestService.save(request);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ReservationRequest> update(@PathVariable Long id, @RequestBody ReservationRequest request) {
        return reservationRequestService.findById(id).map(existing -> {
            request.setId(id);
            return ResponseEntity.ok(reservationRequestService.save(request));
        }).orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        reservationRequestService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
