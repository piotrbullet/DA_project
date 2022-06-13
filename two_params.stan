data {
    int N;
    vector [N] sqft_living;
    vector [N] sqft_lot;
    vector [N] grade;
    real price[N];
}

parameters {
   real alpha;
   real beta_sqft_living;
   real beta_sqft_lot;
   real <lower=0> sigma;
} 

transformed parameters {
   vector [N] mu = alpha+sqft_living*beta_sqft_living+sqft_lot*beta_sqft_lot;
}

model {
   alpha ~ normal(6100, 3000);
   beta_sqft_living ~ normal(240, 30);
   beta_sqft_lot ~ normal(1, 0.7);
   sigma ~ exponential(0.005);
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