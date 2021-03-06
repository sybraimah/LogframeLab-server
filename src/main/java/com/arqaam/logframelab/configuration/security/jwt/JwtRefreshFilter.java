package com.arqaam.logframelab.configuration.security.jwt;

import com.arqaam.logframelab.model.persistence.auth.User;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Component
public class JwtRefreshFilter extends OncePerRequestFilter {

  private static final long ONE_HOUR =  60 * 60L;
  private final JwtTokenProvider jwtTokenProvider;

  public JwtRefreshFilter(JwtTokenProvider jwtTokenProvider) {
    this.jwtTokenProvider = jwtTokenProvider;
  }

  @Override
  protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
      FilterChain filterChain) throws ServletException, IOException {
    String jwt = JwtUtil.getJwtFromRequest(request, jwtTokenProvider);

      Date tokenExpiry = jwtTokenProvider.jwtExpiry(jwt);
      Duration timeToExpire = Duration
              .between(LocalDateTime.now(), LocalDateTime.from(tokenExpiry.toInstant().atZone(ZoneId.systemDefault())));

    if (timeToExpire.getSeconds() <= ONE_HOUR) {
      Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

      if (authentication != null) {
          User user = (User) authentication.getPrincipal();
          String newJwt = jwtTokenProvider.generateToken(user);

          response.setHeader("jws", newJwt);
      }
    }

    filterChain.doFilter(request, response);
  }
}
