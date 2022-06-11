data {
    int N; //number of observations
    vector[N] cigs; //cigarettes sold per adult person 15 years ago
}

generated quantities {
    real theta = gamma_rng(20, 430000);
    int y_sim[N];
    for (k in 1:N) {
        y_sim[k] = poisson_rng(theta*cigs[k]);
    }
}
