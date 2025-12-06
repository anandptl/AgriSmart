package an.sp.main.config;

import an.sp.main.security.JwtAuthenticationFilter;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;

import org.springframework.security.config.annotation.web.builders.HttpSecurity;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
public class SecurityConfig {

    @Autowired
    private JwtAuthenticationFilter jwtFilter;

    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

    	 http
         .authorizeHttpRequests(auth -> auth
             .anyRequest().permitAll()  // allow all requests
         )
         .csrf(csrf -> csrf.disable()) // disable CSRF (for forms/testing)
         .formLogin(login -> login.disable()) // disable Spring Security login
         .httpBasic(basic -> basic.disable()) // disable basic auth
         .logout(logout -> logout
             .logoutUrl("/logout")                 // endpoint for logout
             .logoutSuccessUrl("/login")                // redirect to your login page
             .invalidateHttpSession(true)          // clear session
             .deleteCookies("JSESSIONID")          // remove JSESSIONID cookie
         );

        // Add JWT Filter before UsernamePasswordAuthenticationFilter
        http.addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    // Password encoder
    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // Authentication Manager
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config)
            throws Exception {
        return config.getAuthenticationManager();
    }
}
