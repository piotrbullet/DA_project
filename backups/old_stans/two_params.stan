data {
    int N;
    vector [N] sqft_living;
    vector [N] grade;
    real price[N];
}

parameters {
   real alpha;
   real beta_sqft_living;
   real beta_grade;
   real <lower=0> sigma;
} 

transformed parameters {
   vector [N] mu = alpha+sqft_living*beta_sqft_living+grade*beta_grade;
}

model {
   alpha ~ normal(-589411, 3000);
   beta_sqft_living ~ normal(153, 30);
   beta_grade ~ normal(104795, 0.7);
   sigma ~ exponential(0.1);
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