package com.tenco.team_two_flight_ticket.user;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Entity
@Table(name = "user_tb")
public class User {
    @Id
    private int id;
    private String email;
    private String password;

}
