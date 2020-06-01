package pl.coderslab.survley.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.coderslab.survley.entites.Role;

public interface RoleRepository extends JpaRepository<Role, Long> {
}
