package com.agenda.itic.repository;

import com.agenda.itic.model.ReservationRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ReservationRequestRepository extends JpaRepository<ReservationRequest, Long> {
    List<ReservationRequest> findByStatus(String status);
    List<ReservationRequest> findByUser_Id(Long userId);
    List<ReservationRequest> findByRoom_Id(Long roomId);
}
