package com.nettech.ticket.ticket;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TicketRepository extends JpaRepository<Ticket, Integer> {
    Ticket findById(int id);
    List<Ticket> findAllByStatusTrue();
    List<Ticket> findAllByStatusFalse();
}
