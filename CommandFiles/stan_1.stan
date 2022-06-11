data {
    int N; //number of observations
    int y[N]; // lung cancer deaths ///
    vector [N] pop; //population
}

parameters {
    real<lower=0,upper=1> theta; // bounded deathrate estimate
}

// transformed parameters {
//     vector[N] rate=pop.*theta;
// }


model {
    theta ~ gamma(20, 430000);
    // theta ~ normal(0, 10);
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
