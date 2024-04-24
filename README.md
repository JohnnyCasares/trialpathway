# Clinical Trial Streamlining Application

This application aims to streamline the clinical trial process by leveraging the ClinicalTrials.gov API to allow prospective patients to search for studies.The primary objectives of the app are to improve the recruitment process, enhance communication, improve patient retention, and extract data for training AI models to detect points of failure in the clinical trial process.
Additionally, through data preprocessing, the app aims to provide a clean dataset where keywords are stored for the training of Natural Language Processing algorithms.
## Technologies Used:

- **Application:** The application is developed using the Flutter framework with Dart programming language, allowing for cross-platform development of mobile applications.

- **Database:** PostgreSQL with AACT (Aggregate Analysis of ClinicalTrials.gov): Utilizing the publicly available relational database AACT, which contains all information (protocol and result data elements) about every study registered in ClinicalTrials.gov. Content is downloaded from ClinicalTrials.gov daily and loaded into AACT for streamlined access to comprehensive trial data.

- **API Interaction:** Postman is utilized for testing and interacting with the AACT database endpoints during development to ensure proper integration and functionality.

## Sources:

- [NCBI Bookshelf](https://www.ncbi.nlm.nih.gov/books/NBK50888/): Provides valuable insights into the clinical trial process and best practices.

- [PubMed Central](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6092479/): Offers research articles discussing the challenges and opportunities in clinical trial management and patient recruitment.

- [Regeneron DEVPOST Forum](https://regeneron.devpost.com/forum_topics/38324-track-2-accelerating-clinical-trials-open-source-tools-and-resources): Forum discussions on accelerating clinical trials and open-source tools/resources that can be utilized in the process.

- [ScienceDirect Article](https://www.sciencedirect.com/science/article/pii/S2451865421001307): Provides insights into the use of technology and AI in optimizing clinical trial processes.

## How to Use:
1. **Clone Repository:**
   ```
   git clone https://github.com/JohnnyCasares/clinical_trial_streamlining_app.git
   cd clinical_trial_streamlining_app
   ```
2. **Install Dependencies:**
   ```
   flutter pub get
   ```

3. **Run Application:**
   ```
   flutter run
   ```

4. **Interact with the App:**
    - Use the search functionality to find relevant clinical trials based on different criteria.
    - View detailed information about each clinical trial, including trial contacts, study record dates, outcome measures, trial description, recruitment information, and administrative details.
    - Communicate with trial contacts or site personnel directly through the app.
    - Monitor and track the progress of clinical trials.

## Important: Accessing the Database

To run this project, it's crucial to have access to the AACT (Aggregate Analysis of ClinicalTrials.gov) database. Follow the steps below:

1. **Create an Account:** Visit [AACT](https://aact.ctti-clinicaltrials.org) and create an account if you haven't already done so.

2. **Obtain Credentials:** After creating your account, you'll receive credentials for accessing the database.

3. **Enter Credentials:** Once you have your credentials, enter them into the app to gain access to the database.

It's essential to complete these steps to ensure the app can retrieve comprehensive trial data directly from AACT for use in the application.


## Contributing:

Contributions to the project are welcome! Feel free to fork the repository, make improvements, and submit pull requests. Please follow the existing code style and conventions, and ensure that any changes align with the project's objectives and goals.
