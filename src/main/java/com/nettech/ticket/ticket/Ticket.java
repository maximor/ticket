package com.nettech.ticket.ticket;

import com.nettech.ticket.timeentry.TimeEntry;
import com.nettech.ticket.user.User;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
public class Ticket {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @CreatedDate
    @CreationTimestamp
    private Date creationDate;
    @Column(nullable = false)
    private String subject;
    @Column(nullable = false)
    private String description;
    private boolean status = true;

    private String employeesfield;

    @ManyToMany
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<User> employees;

    @ManyToMany
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<TimeEntry> timeEntries;

    public Ticket() {
    }

    public Ticket(String subject, String description, boolean status) {
        this.subject = subject;
        this.description = description;
        this.status = status;
    }

    public Ticket(String subject, String description, boolean status, String employeesfield) {
        this.subject = subject;
        this.description = description;
        this.status = status;
        this.employeesfield = employeesfield;
    }

    public Ticket(String subject, String description, boolean status, String employeesfield, List<User> employees) {
        this.subject = subject;
        this.description = description;
        this.status = status;
        this.employeesfield = employeesfield;
        this.employees = employees;
    }

    public Ticket(String subject, String description, boolean status, String employeesfield, List<User> employees, List<TimeEntry> timeEntries) {
        this.subject = subject;
        this.description = description;
        this.status = status;
        this.employeesfield = employeesfield;
        this.employees = employees;
        this.timeEntries = timeEntries;
    }

    public Ticket(Date creationDate, String subject, String description, boolean status, String employeesfield, List<User> employees, List<TimeEntry> timeEntries) {
        this.creationDate = creationDate;
        this.subject = subject;
        this.description = description;
        this.status = status;
        this.employeesfield = employeesfield;
        this.employees = employees;
        this.timeEntries = timeEntries;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public List<User> getEmployees() {
        return employees;
    }

    public void setEmployees(List<User> employees) {
        this.employees = employees;
    }

    public List<TimeEntry> getTimeEntries() {
        return timeEntries;
    }

    public void setTimeEntries(List<TimeEntry> timeEntries) {
        this.timeEntries = timeEntries;
    }

    public String getEmployeesfield() {
        return employeesfield;
    }

    public void setEmployeesfield(String employeesfield) {
        this.employeesfield = employeesfield;
    }
}
