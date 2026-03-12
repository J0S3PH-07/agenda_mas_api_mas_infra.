package com.agenda.itic.service;

import com.agenda.itic.model.Reservation;
import com.agenda.itic.repository.ReservationRepository;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class ReservationService {

    private final ReservationRepository reservationRepository;

    public ReservationService(ReservationRepository reservationRepository) {
        this.reservationRepository = reservationRepository;
    }

    public List<Reservation> findAll() {
        return reservationRepository.findAll();
    }

    public Optional<Reservation> findById(Long id) {
        return reservationRepository.findById(id);
    }

    public List<Reservation> findByRoomId(Long roomId) {
        return reservationRepository.findByRoom_Id(roomId);
    }

    public List<Reservation> findByDate(LocalDate date) {
        return reservationRepository.findByReservationDate(date);
    }

    public List<Reservation> findByRoomAndDate(Long roomId, LocalDate date) {
        return reservationRepository.findByRoom_IdAndReservationDate(roomId, date);
    }

    public Reservation save(Reservation reservation) {
        return reservationRepository.save(reservation);
    }

    public void deleteById(Long id) {
        reservationRepository.deleteById(id);
    }
}
