data {
    int N;
    vector [N] sqft;
    vector [N] price; 
}

parameters {
   real <lower=0> alpha;
   real <lower=0> beta;
   real sigma;
}

transformed parameters {
   vector [N] mu;
   for (i in 1:N) {
       mu[i] = alpha + sqft[i]*beta;
   }
}

model {
   alpha ~ normal(360000, 150000);
   beta ~ normal(210, 100);
   sigma ~ exponential(0.01);
   price ~ normal(mu, sigma);
}

generated quantities {
    vector [N] price_sim;
    vector [N] log_lik;
    
    for(i in 1:N){
        log_lik[i] = normal_lpdf(price[i] | mu[i], sigma);
        price_sim[i] = normal_rng(mu[i], sigma);
    }
}