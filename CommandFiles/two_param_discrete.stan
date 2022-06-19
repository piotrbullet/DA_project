data {
    int N;
    vector [N] sqft;
    int grade [N];
    vector [N] price;
}

parameters {
   real alpha;
   real <lower=0> beta_sqft;
   vector [6] beta_grade;
   real sigma;
} 

transformed parameters {
   vector [N] mu;
    for (i in 1:N) {
        mu[i] = alpha + sqft[i]*beta_sqft + beta_grade[grade[i]+1];
    }
}

model {
   alpha ~ normal(360000, 150000);
   beta_sqft ~ normal(210, 100);
   for (i in 1:6) {
      beta_grade[i] ~ normal(0, 1000000);
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