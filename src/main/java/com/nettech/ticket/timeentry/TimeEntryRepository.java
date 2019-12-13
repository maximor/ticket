package com.nettech.ticket.timeentry;

import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;

public interface TimeEntryRepository extends JpaRepository<TimeEntry, Integer> {
    TimeEntry findById(int id);
    List<TimeEntry> findAllByInitialDateGreaterThanEqualAndEndDateLessThanEqual(LocalDateTime initialDate, LocalDateTime endDate);
}
