import subprocess, datetime, os

os.mkdir("../logs", exit_ok=True)

plan = subprocess.run(["terraform", "plan"], capture_output=True, text=True)

timestamp = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
with open(f"../logs/terraform_plan_{timestamp}.log", "w") as log:
    log.write(plan.stdout)