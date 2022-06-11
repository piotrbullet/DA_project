data {
    int N; //number of observations
    int y[N]; // lung cancer
    vector [N] pop; //population
}

parameters {
    vector<lower=0,upper=1>[N] theta; // bounded deathrate estimate
}

transformed parameters {
    vector[N] lambda=pop.*theta;
}


model {
    theta ~ gamma(20, 430000);
    y ~ poisson(lambda);
}