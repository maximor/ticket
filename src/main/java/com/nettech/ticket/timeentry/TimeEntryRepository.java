package com.nettech.ticket.timeentry;

import org.springframework.data.jpa.repository.JpaRepository;

public interface TimeEntryRepository extends JpaRepository<TimeEntry, Integer> {
    TimeEntry findById(int id);
}
