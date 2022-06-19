data {
    int N;
    vector [N] sqft_living;
    vector [N] grade;
    vector [N] price;
}

parameters {
   real alpha;
   real <lower=0> beta_sqft_living;
   real <lower=0> beta_grade;
   real sigma;
} 

transformed parameters {
   vector [N] mu = alpha+sqft_living*beta_sqft_living+grade*beta_grade;
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
   vector [N] prices;
   vector [N] log_lik;
   for (i in 1:N) {
       prices[i] = normal_rng(mu[i], sigma);
       log_lik[i] = normal_lpdf(price[i] | mu[i], sigma);
   }
}