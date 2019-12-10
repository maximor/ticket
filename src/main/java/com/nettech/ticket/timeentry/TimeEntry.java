package com.nettech.ticket.timeentry;

import com.nettech.ticket.user.User;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
public class TimeEntry {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @Column(nullable = false)
    private Date InitialDate;
    @Column(nullable = false)
    private Date endDate;
    @Column(nullable = false)
    private String note;

    @ManyToMany(fetch = FetchType.EAGER)
    private List<User> employees;

    public TimeEntry() {
    }

    public TimeEntry(Date InitialDate, Date endDate, String note) {
        this.InitialDate = InitialDate;
        this.endDate = endDate;
        this.note = note;
    }

    public TimeEntry(Date InitialDate, Date endDate, String note, List<User> employees) {
        this.InitialDate = InitialDate;
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

    public Date getInitialDate() {
        return InitialDate;
    }

    public void setInitialDate(Date initialDate) {
        this.InitialDate = initialDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
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
