data {
    int N;
    vector [N] sqft;
    vector [N] grade;
}

generated quantities {
    real alpha =  normal_rng(-589411, 3000);
    real beta_sqft = normal_rng(153, 30);
    real beta_grade = normal_rng(104795, 0.7);
    real sigma = exponential_rng(0.1);
    vector [N] price;
    for (i in 1:N) {
        price[i] = normal_rng(alpha + sqft[i]*beta_sqft + grade[i]*beta_grade, sigma);
    }
}