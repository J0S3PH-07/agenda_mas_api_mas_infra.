package com.agenda.itic.service;

import com.agenda.itic.model.ReservationRequest;
import com.agenda.itic.repository.ReservationRequestRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class ReservationRequestService {

    private final ReservationRequestRepository reservationRequestRepository;

    public ReservationRequestService(ReservationRequestRepository reservationRequestRepository) {
        this.reservationRequestRepository = reservationRequestRepository;
    }

    public List<ReservationRequest> findAll() {
        return reservationRequestRepository.findAll();
    }

    public Optional<ReservationRequest> findById(Long id) {
        return reservationRequestRepository.findById(id);
    }

    public List<ReservationRequest> findByStatus(String status) {
        return reservationRequestRepository.findByStatus(status);
    }

    public List<ReservationRequest> findByUserId(Long userId) {
        return reservationRequestRepository.findByUser_Id(userId);
    }

    public ReservationRequest save(ReservationRequest request) {
        return reservationRequestRepository.save(request);
    }

    public void deleteById(Long id) {
        reservationRequestRepository.deleteById(id);
    }
}
