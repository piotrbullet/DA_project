data {
    int N;
    vector [N] sqft_living;
    vector [N] grade;
    vector [N] price;
}

parameters {
   real alpha;
   real <lower=0> beta_sqft_living;
   vector [6] beta_grade;
   real sigma;
} 

transformed parameters {
   vector [N] mu;
    for (i in 1:N) {
        mu[i] = alpha + sqft_living[i]*beta_sqft_living + beta_grade[grade[i]+1];
    }
}

model {
   alpha ~ normal(500000, 200000);
   beta_sqft_living ~ normal(0, 1000);
   for (i in 1:6) {
      beta_grade[i] ~ normal(100000, 50000);
   }
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