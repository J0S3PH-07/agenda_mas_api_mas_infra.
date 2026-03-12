package com.agenda.itic.controller;

import com.agenda.itic.model.Reservation;
import com.agenda.itic.service.ReservationService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/reservations")
public class ReservationController {

    private final ReservationService reservationService;

    public ReservationController(ReservationService reservationService) {
        this.reservationService = reservationService;
    }

    @GetMapping
    public List<Reservation> findAll() {
        return reservationService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Reservation> findById(@PathVariable Long id) {
        return reservationService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/room/{roomId}")
    public List<Reservation> findByRoom(@PathVariable Long roomId) {
        return reservationService.findByRoomId(roomId);
    }

    @GetMapping("/date/{date}")
    public List<Reservation> findByDate(
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        return reservationService.findByDate(date);
    }

    @GetMapping("/room/{roomId}/date/{date}")
    public List<Reservation> findByRoomAndDate(
            @PathVariable Long roomId,
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        return reservationService.findByRoomAndDate(roomId, date);
    }

    @PostMapping
    public Reservation create(@RequestBody Reservation reservation) {
        return reservationService.save(reservation);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Reservation> update(@PathVariable Long id, @RequestBody Reservation reservation) {
        return reservationService.findById(id).map(existing -> {
            reservation.setId(id);
            return ResponseEntity.ok(reservationService.save(reservation));
        }).orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        reservationService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
