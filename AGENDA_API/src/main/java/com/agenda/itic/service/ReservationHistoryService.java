package com.agenda.itic.service;

import com.agenda.itic.model.ReservationHistory;
import com.agenda.itic.repository.ReservationHistoryRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class ReservationHistoryService {

    private final ReservationHistoryRepository reservationHistoryRepository;

    public ReservationHistoryService(ReservationHistoryRepository reservationHistoryRepository) {
        this.reservationHistoryRepository = reservationHistoryRepository;
    }

    public List<ReservationHistory> findAll() {
        return reservationHistoryRepository.findAll();
    }

    public Optional<ReservationHistory> findById(Long id) {
        return reservationHistoryRepository.findById(id);
    }

    public List<ReservationHistory> findByReservationId(Long reservationId) {
        return reservationHistoryRepository.findByReservationId(reservationId);
    }

    public ReservationHistory save(ReservationHistory history) {
        return reservationHistoryRepository.save(history);
    }
}
