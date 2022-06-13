data {
    int N;
    vector [N] sqft;
    vector [N] grade;
    real price[N];
}

parameters {
   real alpha;
   real beta_sqft;
   real beta_grade;
   real <lower=0> sigma;
} 

transformed parameters {
   vector [N] mu = sqft*beta_sqft+grade*beta_grade+alpha;
   // vector [N] mu = (sqft*beta_sqft+alpha)*grade*beta_grade;
}

model {
   alpha ~ normal(44000, 2500);
   beta_sqft ~ normal(280, 150);
   beta_grade ~ normal(0,1);
   sigma ~ exponential(0.01);
   price ~ normal(mu, sigma);
}

generated quantities {
   real prices[N];
   real log_lik[N];
   for (i in 1:N) {
       prices[i] = normal_rng(mu[i], sigma);
       log_lik[i] = normal_lpdf(price[i] | mu[i], sigma);
   }
}