package pl.coderslab.survley.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.coderslab.survley.entites.User;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
    User findUserById(long id);
}
