using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace value_sample_api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EValuesController : ControllerBase
    {
        // GET api/evalues
        [HttpGet]
        public ActionResult<IEnumerable<string>> Get()
        {
            return new string[] {
                $"Env Value for MY_VAL1- {System.Environment.ExpandEnvironmentVariables("%MY_VAL1%")}",
                "value2" };
        }
    }
}
