package pl.coderslab.survley.Service;

import pl.coderslab.survley.entites.User;

public interface UserService {
    void save(User user);

    User findByUsername(String username);
}
