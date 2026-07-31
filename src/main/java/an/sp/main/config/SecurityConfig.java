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
         .csrf(csrf -> csrf.disable())
         .formLogin(login -> login.disable()) 
         .httpBasic(basic -> basic.disable())
         .logout(logout -> logout
             .logoutUrl("/logout")
             .logoutSuccessUrl("/login")
             .invalidateHttpSession(true)
             .deleteCookies("JSESSIONID")
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
