package an.sp.main.util;

import java.util.Date;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.*;

import io.jsonwebtoken.security.Keys;
import javax.crypto.SecretKey;

@Component
public class JwtUtil {

    @Value("${jwt.secret}")
    private String secretKey;

    private final long EXPIRATION = 1000 * 60 * 60 * 5; // 5 hours

    private SecretKey getKey() {
        return Keys.hmacShaKeyFor(secretKey.getBytes());
    }

    // Generate Token
    public String generateToken(String email, String role) {
        return Jwts.builder()
                .setSubject(email)
                .claim("role", role)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION))
                .signWith(getKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    // Extract email
    public String extractEmail(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(getKey())
                .build()
                .parseClaimsJws(token)
                .getBody()
                .getSubject();
    }

    // Validate Token
    public boolean validateToken(String token) {
        try {
            Jwts.parserBuilder()
                    .setSigningKey(getKey())
                    .build()
                    .parseClaimsJws(token);
            return true;
        } catch (Exception e) {
            System.out.println("JWT Error: " + e.getMessage());
            return false;
        }
    }
}
