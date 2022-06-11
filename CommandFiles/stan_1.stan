data {
    int N; //number of observations
    int y[N]; // lung cancer deaths rate
}

parameters {
    real<lower=0,upper=1> theta; // bounded deathrate estimate
}

model {
    theta ~ gamma(20, 430000);
    for (k in 1:N) {
        y[k] ~ poisson(theta);
    }
}

generated quantities {
   int y_sim[N];
   for (k in 1:N) {
       y_sim[k] = poisson_rng(theta);
   }
}
