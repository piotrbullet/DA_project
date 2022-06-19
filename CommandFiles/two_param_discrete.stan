data {
    int N;
    vector [N] sqft_living;
    vector [N] grade;
    real price[N];
}

parameters {
   real alpha;
   real <lower=0> beta_sqft_living;
   real <lower=0> [6] beta_grade;
   real <lower=0> sigma;
} 

transformed parameters {
   vector [N] mu = alpha+sqft_living*beta_sqft_living+grade*beta_grade;
    for (i in 1:N) {
        
    }
}

model {
   alpha ~ normal(0, 1);
   beta_sqft_living ~ normal(0, 1);
   beta_grade ~ normal(0, 1);
   // alpha ~ normal(500000, 1000);
   // beta_sqft_living ~ normal(0, 20000);
   // beta_grade ~ normal(0, 20000);
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