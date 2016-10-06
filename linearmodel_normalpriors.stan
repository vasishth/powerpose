data { int N;
  real change[N];
  real female[N]; 
  real treatment[N];
  }
parameters {
  real alpha;
  real beta_female;
  real beta_treatment;
  real beta_interaction;
  real<lower = 0> sigma;
} 
model {
  // priors probably need more thought:
  alpha ~ normal(0,20);
  beta_female ~ normal(0,20);
  beta_treatment ~ normal(0,20);
  beta_interaction ~ normal(0,20);
  sigma ~ cauchy(0,1);
  
  for (n in 1:N) {
    change[n] ~ normal(alpha + beta_female * female[n] + beta_treatment * treatment[n] + beta_interaction * female[n] * treatment[n], sigma);
  } }
generated quantities {
  real change_ppc[N];
  for (n in 1:N) {
    change_ppc[n] = normal_rng(alpha + beta_female * female[n] + beta_treatment * treatment[n] + beta_interaction * female[n] * treatment[n], sigma);
  }
}
