package com.agenda.itic.repository;

import com.agenda.itic.model.ReservationHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ReservationHistoryRepository extends JpaRepository<ReservationHistory, Long> {
    List<ReservationHistory> findByReservationId(Long reservationId);
    List<ReservationHistory> findByRoomId(Long roomId);
}
