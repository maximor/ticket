package com.nettech.ticket.timeentry;

import com.nettech.ticket.user.User;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Entity
public class TimeEntry {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @Column(nullable = false)
    private LocalDateTime initialDate;
    @Column(nullable = false)
    private LocalDateTime endDate;
    @Column(nullable = false)
    private String note;

    @ManyToMany(fetch = FetchType.EAGER)
    private List<User> employees;

    public TimeEntry() {
    }

    public TimeEntry(LocalDateTime InitialDate, LocalDateTime endDate, String note) {
        this.initialDate = InitialDate;
        this.endDate = endDate;
        this.note = note;
    }

    public TimeEntry(LocalDateTime InitialDate, LocalDateTime endDate, String note, List<User> employees) {
        this.initialDate = InitialDate;
        this.endDate = endDate;
        this.note = note;
        this.employees = employees;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public LocalDateTime getInitialDate() {
        return initialDate;
    }

    public void setInitialDate(LocalDateTime initialDate) {
        this.initialDate = initialDate;
    }

    public LocalDateTime getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDateTime endDate) {
        this.endDate = endDate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public List<User> getEmployees() {
        return employees;
    }

    public void setEmployees(List<User> employees) {
        this.employees = employees;
    }
}
