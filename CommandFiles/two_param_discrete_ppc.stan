data {
    int N;
    vector [N] sqft;
    vector [N] grade;
}

generated quantities {
    real alpha =  normal_rng(500000, 200000);
    real beta_sqft = normal_rng(0, 1000);
    vector [6] beta_grade;
    for (i in 1:6) {
        beta_grade[i] = normal_rng(100000, 50000);
    }
    real sigma = exponential_rng(0.01);
    vector [N] price;
    for (i in 1:N) {
        price[i] = normal_rng(alpha + sqft[i]*beta_sqft + beta_grade[grade[i]+1], sigma);
    }
}