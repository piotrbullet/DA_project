data {
    int N; //number of observations
    int y[N]; // lung cancer deaths ///
    vector [N] pop; //population
}

parameters {
    vector<lower=0,upper=1>[N] theta; // bounded deathrate estimate
}

transformed parameters {
    vector[N] rate=pop.*theta;
}


model {
    theta ~ gamma(20, 430000);
    for (k in 1:N) {
        y[k] ~ poisson(rate);
    }
}

generated quantities {
   int y_sim[N];
   for (k in 1:N) {
        y_sim[k] ~ poisson_rng(rate);
   }
}
